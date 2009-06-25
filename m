From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V3
Date: Thu, 25 Jun 2009 11:25:39 +0900
Message-ID: <aec7e5c30906241925n3eeaee65of0dcf0286f60366d@mail.gmail.com>
References: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
	<87r5xhqzr4.fsf@deeprootsystems.com>
	<aec7e5c30906240450w2c204b1bo8e06cdc26eaad753@mail.gmail.com>
	<200906242050.57312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906242050.57312.rjw@sisk.pl>
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
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 25, 2009 at 3:50 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Wednesday 24 June 2009, Magnus Damm wrote:
>> On Fri, Jun 19, 2009 at 1:21 AM, Kevin
>> Hilman<khilman@deeprootsystems.com> wrote:
>> > Magnus Damm <magnus.damm@gmail.com> writes:
>> >
>> >> From: Magnus Damm <damm@igel.co.jp>
>> >>
>> >> Allow architecture specific data in struct platform_device V3.
>> >>
>> >> With this patch struct pdev_archdata is added to struct
>> >> platform_device, similar to struct dev_archdata in found in
>> >> struct device. Useful for architecture code that needs to
>> >> keep extra data associated with each platform device.
>> >>
>> >> Struct pdev_archdata is different from dev.platform_data, the
>> >> convention is that dev.platform_data points to driver-specific
>> >> data. It may or may not be required by the driver. The format
>> >> of this depends on driver but is the same across architectures.
>> >>
>> >> The structure pdev_archdata is a place for architecture specific
>> >> data. This data is handled by architecture specific code (for
>> >> example runtime PM), and since it is architecture specific it
>> >> should _never_ be touched by device driver code. Exactly like
>> >> struct dev_archdata but for platform devices.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> >
>> > Since there is no 'Feature-desired-by:' tag, I'll addd
>> >
>> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>> >
>> > For PM on ARM in general, and OMAP in particular we definitely need a
>> > generic way to handle arch-specific data per platform_device.
>>
>> Thanks, Kevin! So ARM in general or at least OMAP wants this, and so
>> does SuperH.
>>
>> Rafael, you kindly gave feedback on earlier versions, are you ok with
>> this version?
>
> Yes, I am. =A0I'm planning to include it into my linux-next branch for 2.=
6.32, if
> no one objects.

Do you have any specific reason for not including this one in 2.6.31?
I guess you were thinking of keeping it together with your Runtime PM
patches targeted for 2.6.32?

IMO, this patch is decoupled from Runtime PM. It will of course be
used for Runtime PM on SuperH, but it can for instance also be used
together with the clock framework.  On top of that, the patch is only
adding code so it's very unlikely to cause any breakage.

If possible, I'd like this to be merged as early as possible since a
lot of processor specific changes will depend on it. With this
included in 2.6.31 I can easily build arch specific code for 2.6.32.
Anything I can do to make that happen?

My top priority is Runtime PM for SuperH on top of your code, and I
intend to post a prototype for SuperH before the PM Summit. It would
be great to minimize the dependencies though, and including this in
2.6.31 would certainly help.

Thanks!

/ magnus
