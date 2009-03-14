From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH][0/8] PM: Rework suspend-resume ordering
	to avoid problems with shared interrupts
Date: Sat, 14 Mar 2009 09:44:35 +0100
Message-ID: <200903140944.37081.elendil__48148.0988128625$1237020564$gmane$org@planet.nl>
References: <200902221837.49396.rjw@sisk.pl>
	<200903082028.03720.elendil@planet.nl>
	<200903082150.55377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903082150.55377.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 March 2009, Rafael J. Wysocki wrote:
> > # These don't need restoring anymore?
>
> I think they generally do, but the restored values may (and often are)
> identical to the current ones.
>
> > =A0 =A0-pci 0000:00:02.1: restoring config space at offset 0x4 (was 0x4=
, writing 0xe0500004)
> >    -pci 0000:00:02.1: restoring config space at offset 0x1 (was 0x90000=
0, writing 0x900007)
> >    -pci 0000:00:03.0: restoring config space at offset 0xf (was 0x100, =
writing 0x1ff)
> >    -pci 0000:00:03.0: restoring config space at offset 0x4 (was 0xfed12=
004, writing 0xe0600004)
> >    -pci 0000:00:03.2: restoring config space at offset 0xf (was 0x300, =
writing 0x30b)
> >    -pci 0000:00:03.2: restoring config space at offset 0x8 (was 0x1, wr=
iting 0x2031)
> >    -pci 0000:00:03.2: restoring config space at offset 0x7 (was 0x1, wr=
iting 0x2021)
> >    -pci 0000:00:03.2: restoring config space at offset 0x6 (was 0x1, wr=
iting 0x2019)
> >    -pci 0000:00:03.2: restoring config space at offset 0x5 (was 0x1, wr=
iting 0x2011)
> >    -pci 0000:00:03.2: restoring config space at offset 0x4 (was 0x1, wr=
iting 0x2009)
> >    -pci 0000:00:03.2: restoring config space at offset 0x1 (was 0xb0000=
0, writing 0xb00001)
[...]
> > # These have moved down to late resume.
>
> That's a bit strange. =A0It looks like the registers changed after we had
> restored them during "early" resume. =A0So either we hadn't actually
> restored them (it would be interesting to find out why), or they really
> changed (again, it would be interesting to see why).
>
> > =A0 =A0-uhci_hcd 0000:00:1a.0: restoring config space at offset 0xf (wa=
s 0x100, writing 0x10a)
> > =A0 =A0-uhci_hcd 0000:00:1a.0: restoring config space at offset 0x8 (wa=
s 0x1, writing 0x2081)
> > =A0 =A0-uhci_hcd 0000:00:1a.0: restoring config space at offset 0x1 (wa=
s 0x2800000, writing 0x2800001)
> > =A0 =A0-uhci_hcd 0000:00:1a.1: restoring config space at offset 0xf (wa=
s 0x200, writing 0x20a)
> > =A0 =A0-uhci_hcd 0000:00:1a.1: restoring config space at offset 0x8 (wa=
s 0x1, writing 0x20a1)
> > =A0 =A0-uhci_hcd 0000:00:1a.1: restoring config space at offset 0x1 (wa=
s 0x2800000, writing 0x2800001)

These changes look to have been reverted somehow with rc8 + your latest
patch set. Not sure if it's due to changes in the patches, or just an
effect of local circumstances (such as (un)suspending while the system
is docked). Or sun spots of course.

The "restoring config space" messages now look virtually the same
as for rc5, only some messages for the ricoh-mmc module are still
"missing", but I'm not worried about that.

Cheers,
FJP
