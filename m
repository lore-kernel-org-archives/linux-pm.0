From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Mon, 31 Jan 2011 20:18:44 -0700
Message-ID: <AANLkTinEsUOZQURXOfAVoTU5=k0mi8PC0_Gte6gACDFj__40646.9859801748$1296530738$gmane$org@mail.gmail.com>
References: <201101300107.19389.rjw@sisk.pl>
	<20110131225902.GD27856@angua.secretlab.ca>
	<201102010010.46096.rjw@sisk.pl> <871v3s3ahe.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <871v3s3ahe.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 31, 2011 at 4:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>
>>> Also, what is the use case for having 2 sets of power_domain ops? =A0My
>>> gut tells me that you'd only want to do post ops on the
>>> {freeze,suspend,poweroff} path and pre ops on the {resume,thaw,restore}
>>> path. =A0It seems overly engineered to me, but I may be missing
>>> something fundamental.
>>
>> Well, that's a part of the RFC, actually. :-)
>>
>> For the subsystems I've worked with (PCI, ACPI, PNP to some extent) one =
set
>> would be sufficient, but I don't know of every possible use case.
>
> For the on-chip SoC devices we're managing with OMAP, we're currently
> only using one set: post ops on [runtime_]suspend and pre ops on
> [runtime_]resume.
>
> However, I could imagine (at least conceptually) using the pre ops on
> suspend to do some constraints checking and/or possibly some
> management/notification of dependent devices. =A0Another possiblity
> (although possibly racy) would be using the pre ops on suspend to
> initiate some high-latency operations.
>
> I guess the main problem with two sets is wasted space. =A0e.g, if I move
> OMAP to this (already hacking on it) there will be only 2 functions used
> in post ops: [runtime_]suspend() and 2 used in pre ops [runtime_]_resume(=
).

There's a conceptual load added to the (human) reader too.  Every
additional hook point is an additional piece other engineers need to
fit into their mental model.  I'm resistant to having the two sets of
ops without a definite use case for it when conceptually I can only
imagine a need for one set.

g.
