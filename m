From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: power/level and power/control
Date: Fri, 12 Mar 2010 12:04:51 +0100
Message-ID: <ac3eb2511003120304v39387563l95d2a9c6a00f3f5d__10250.7251351655$1268392058$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
	<201003120943.09520.oliver@neukum.org>
	<ac3eb2511003120047l510fd464w31280f28c48f163a@mail.gmail.com>
	<201003121008.49246.oliver@neukum.org>
	<ac3eb2511003120122n33130d22k61ca18ecf0d14e80@mail.gmail.com>
	<e6a3c75f1003120257i4adc05f0h83f48e76af1abaa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <e6a3c75f1003120257i4adc05f0h83f48e76af1abaa5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nithish Mahalingam <nithish.m@gmail.com>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 12, 2010 at 11:57, Nithish Mahalingam <nithish.m@gmail.com> wrote:
>> >>> > Has support in user space hardware abstraction layers for runtime
>> >>> > power management been added? It seems to me that we need this.
>> >>>
>> >>> There is no major project I know of, which uses these things, and
>> >>> nothing I know of people would work on at the moment.
>> >>
>> >> If this were to be added, which project should it be added to?
>> >
>> > I don't think there is an existing project that would really fit here.
>> >
>> >> I don't think handling this with udev scripts is a good idea, because
>> >> you want to be able to revisit such decisions when you go to
>> >> battery power or power is low, for example whether you want to
>> >> charge your cell phone.
>> >
>> > Right, that needs policy to apply, depending on the current state. But
>> > unfortunately there is no existing infrastructure we could easily
>> > extend, it would be something new to come up with.
>
> Shouldn't it suffice to extend usb_device namespace values in HAL
> specification for runtime PM and once added let distribution
> specific user space PM framework handle this.
> http://people.redhat.com/davidz/hal-spec/hal-spec.html#device-properties-usb
>
> I guess the industry is moving towards DeviceKit, anyway that is just
> implementation specific.

There is no HAL anymore, it's dead and no longer maintained. DeviceKit
was only a temporary name, and does not exist as a project.

HAL is split into pieces, like udisks, upower, and along with udev,
PulseAudio, NetworkManager, ConsoleKit, PolicyKit, ..., there are
specialized daemons taking care of domain-specific tasks. There is
nothing really where USB power management would really fit in today.

Kay
