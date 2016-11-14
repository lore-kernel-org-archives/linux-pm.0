From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Mon, 14 Nov 2016 08:00:48 -0800
Message-ID: <CAB=NE6V59RYf0rD4H+LL4uJwEGHasG9xG8jP4fJU7qoefsTqeQ@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan> <20161107213954.GI1764@wotan.suse.de>
 <20161113173413.GB9598@wunner.de> <20161114134831.GX13978@wotan.suse.de> <20161114154805.GC10141@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114154805.GC10141@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 7:48 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Nov 14, 2016 at 02:48:32PM +0100, Luis R. Rodriguez wrote:
>> On Sun, Nov 13, 2016 at 06:34:13PM +0100, Lukas Wunner wrote:
>> > On Mon, Nov 07, 2016 at 10:39:54PM +0100, Luis R. Rodriguez wrote:
>> > > On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
>> > > > One of the actions carried out by device_link_add() is to reorder
>> > > > the lists used for device shutdown and system suspend/resume to
>> > > > put the consumer device along with all of its children and all of
>> > > > its consumers (and so on, recursively) to the ends of those lists
>> > > > in order to ensure the right ordering between all of the supplier
>> > > > and consumer devices.
>> > >
>> > > There's no explanation as to why this order is ensured to be
>> > > correct, I think its important to document this. From our discussions
>> > > at Plumbers it seems the order is ensured due to the fact that order
>> > > was already implicitly provided through platform firmware (ACPI
>> > > enumeration is one), adjusting order on the dpm list is just shuffling
>> > > order between consumer / provider, but nothing else.
>> >
>> > ACPI specifies a hierarchy and the order on the dpm_list and
>> > devices_kset is such that children are behind their parent.
>> >
>> > A device link specifies a dependency that exists in addition
>> > to the hierarchy, hence consumers need to be moved behind
>> > their supplier.  And not only the consumers themselves but
>> > also recursively their children and consumers. Essentially
>> > the entire subtree is moved to the back.  That happens in
>> > device_reorder_to_tail() in patch 2.
>>
>> Ah neat, I failed to notice this full subtree tree move, its
>> rather important.
>>
>> > If another device is enumerated which acts as a supplier to
>> > an existing other supplier, that other supplier and all its
>> > dependents are moved behind the newly enumerated device,
>> > and so on.
>> >
>> > That is probably correct so long as no loops are introduced
>> > in the dependency graph.
>>
>> "Probably" is what concerns me, there is no formality about
>> the correctness of this.
>
> It's a typo, I meant to say "provably correct". Sorry.
>
> Quite a difference in meaning. :-)

No sorry my own mistake -- you had written provably but I thought you
had a typo, clearly you meant as you typed :)

If the trees are independent then yes, I can see this working.

>> > That is checked by device_is_dependent(),
>> > which is called from device_link_add(), and the addition of the
>> > link is aborted if a loop is detected.
>>
>> And that is sufficient ?
>
> The device links turn the device tree into a directed acyclic graph.
> For the dpm_list and devices_kset, that graph is flattened into a
> one-dimensional form such that all ancestors and suppliers of a
> device appear in front of that device in the lists.  I'm not a
> graph theorist and can't provide a formal proof.  I think Rafael
> is a Dr., maybe he can do it. :-)

If you traverse the DAG you can get a linear one-dimensional
representation of the dependencies -- I'm no expert on this either,
however I'm buying what you described above then, provided we do
indeed avoid cycles.

> I merely looked at this from a
> practical point of view, i.e. I tried to come up with corner cases
> where dependencies are added that would result in incorrect ordering,
> and concluded that I couldn't find any.

Fair enough, likewise. I think the takeaway from this discussion is a
test driver trying to break this might be good to have, but also
documenting how this works in practice and how we avoid the cycles is
important. This was not very clear from the patches.

 Luis
