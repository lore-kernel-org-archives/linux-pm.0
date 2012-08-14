From: Aaron Lu <ziqian.lu@intel.com>
Subject: Re: FW: bisected regression: v3.6-rc1: resume from s2ram
 does not restore ata_piix (v3.5 worked)
Date: Tue, 14 Aug 2012 15:51:16 +0800
Message-ID: <502A0374.60803@intel.com>
References: <CA2E3DE2DD06CA4FA11644750E4E292F102ACD65@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------000704080706060008030304"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CA2E3DE2DD06CA4FA11644750E4E292F102ACD65@SHSMSX102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sergei Trofimovich <slyich@gmail.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, Lin Ming <minggr@gmail.com>, linux-pm@lists.linux-foundation.org, Jeff Garzik <jgarzik@redhat.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704080706060008030304
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Hi Sergei,

The only problem I can see is the offending commit didn't do a gtm for
IDE channel during init. It was used to be done in
ata_acpi_associate_ide_port.

So can you please test if the following code fix your problem? Thanks.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 902b5a4..0f338bb 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -1101,6 +1101,9 @@ static int ata_acpi_bind_host(struct ata_port *ap,
acpi_handle *handle)
if (!*handle)
return -ENODEV;

+ if (ata_acpi_gtm(ap, &ap->__acpi_init_gtm) == 0)
+ ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
+
return 0;
}

Thanks,
Aaron

> ---------- Forwarded message ----------
> From: Sergei Trofimovich <slyich@gmail.com>
> Date: Mon, Aug 13, 2012 at 5:20 PM
> Subject: bisected regression: v3.6-rc1: resume from s2ram does not
restore ata_piix (v3.5 worked)
> To: linux-pm@lists.linux-foundation.org, Matthew Garrett
<mjg@redhat.com>, Holger Macht <holger@homac.de>, Lin Ming
<ming.m.lin@intel.com>, Jeff Garzik <jgarzik@redhat.com>
> Cc: linux-kernel@vger.kernel.org
>
>
> It's a laptop compaq 2510p (~5 years old core2 laptop) with a single
SATA drive:
>
> 00:1f.1 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E)
IDE Controller (rev 03)
> Subsystem: Hewlett-Packard Company Device 30c9
> Kernel driver in use: ata_piix
>
> kernel v3.5 worked fine. 3.6-rc1 resumes, but disk stays inaccessble.
> Seems to be 100% reproducible. Bisection gave sane result[1].
>
> I was not able to revert it as-is, thus couldn't verify the revert
helps on top of master.
>
> Do you need more info?
>
> Thanks!
>
> [1]
> commit 30dcf76acc695cbd2fa919e294670fe9552e16e7
> Author: Matthew Garrett <mjg@redhat.com>
> Date: Mon Jun 25 16:13:04 2012 +0800
>
> libata: migrate ACPI code over to new bindings
>
> Now that we have the ability to directly glue the ACPI namespace to the
> driver model in libata, we don't need the custom code to handle the same
> thing. Remove it and migrate the functions over to the new code.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Holger Macht <holger@homac.de>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
>
> :040000 040000 6a659a9d4a92b2085f6d0b58484cb2f82cd12cfa
> 125fe5d5fa8b208a08792b03e752571d825465d2 M drivers
> :040000 040000 b7c3819be4e82ae6e2ac9688055aeb2bc1bc4ebd
> 9cbc8fd15b147a178f723bcdb9e7c34f9868400f M include
>
> git bisect good 492d542273a4859f8bf8cc7744cdf71ef50b39ea
> # bad: [354b2eac3848bddbcb111079138b907ccca70ae8] libata-acpi: fix up
for acpi_pm_device_sleep_state API git bisect bad
354b2eac3848bddbcb111079138b907ccca70ae8
> # bad: [dc7f71f486f4f5fa96f6dcf86833da020cde8a11] sata_dwc_460ex:
> device tree may specify dma_channel
> git bisect bad dc7f71f486f4f5fa96f6dcf86833da020cde8a11
> # bad: [91e4d5a1d7d11ca0b08803a11cb8dc866d2d611f] drivers/acpi/glue:
> revert accidental license-related 6b66d95895c bits git bisect bad
91e4d5a1d7d11ca0b08803a11cb8dc866d2d611f
> # bad: [3bd46600a7a7e938c54df8cdbac9910668c7dfb0] libata-acpi: add ata
port runtime D3Cold support git bisect bad
3bd46600a7a7e938c54df8cdbac9910668c7dfb0
> # bad: [30dcf76acc695cbd2fa919e294670fe9552e16e7] libata: migrate ACPI
code over to new bindings git bisect bad
30dcf76acc695cbd2fa919e294670fe9552e16e7
> # good: [6b66d95895c149cbc04d4fac5a2f5477c543a8ae] libata: bind the
Linux device tree to the ACPI device tree git bisect good
6b66d95895c149cbc04d4fac5a2f5477c543a8ae
> # good: [6b66d95895c149cbc04d4fac5a2f5477c543a8ae] libata: bind the
Linux device tree to the ACPI device tree git bisect good
6b66d95895c149cbc04d4fac5a2f5477c543a8ae
> 30dcf76acc695cbd2fa919e294670fe9552e16e7 is the first bad commit
>
> --
>
> Sergei


--------------000704080706060008030304
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=GB2312" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Sergei,<br>
    <br>
    The only problem I can see is the offending commit didn't do a gtm
    for<br>
    IDE channel during init. It was used to be done in<br>
    ata_acpi_associate_ide_port.<br>
    <br>
    So can you please test if the following code fix your problem?
    Thanks.<br>
    <br>
    diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c<br>
    index 902b5a4..0f338bb 100644<br>
    --- a/drivers/ata/libata-acpi.c<br>
    +++ b/drivers/ata/libata-acpi.c<br>
    @@ -1101,6 +1101,9 @@ static int ata_acpi_bind_host(struct ata_port
    *ap, acpi_handle *handle)<br>
    &nbsp;&nbsp;&nbsp; &nbsp;if (!*handle)<br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return -ENODEV;<br>
    &nbsp;<br>
    +&nbsp;&nbsp; &nbsp;if (ata_acpi_gtm(ap, &amp;ap-&gt;__acpi_init_gtm) == 0)<br>
    +&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;ap-&gt;pflags |= ATA_PFLAG_INIT_GTM_VALID;<br>
    +<br>
    &nbsp;&nbsp;&nbsp; &nbsp;return 0;<br>
    &nbsp;}<br>
    <br>
    Thanks,<br>
    Aaron<br>
    <br>
    <span style="white-space: pre;">&gt; ---------- Forwarded message
      ----------<br>
      &gt; From: Sergei Trofimovich <a class="moz-txt-link-rfc2396E" href="mailto:slyich@gmail.com">&lt;slyich@gmail.com&gt;</a><br>
      &gt; Date: Mon, Aug 13, 2012 at 5:20 PM<br>
      &gt; Subject: bisected regression: v3.6-rc1: resume from s2ram
      does not restore ata_piix (v3.5 worked)<br>
      &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.linux-foundation.org</a>, Matthew Garrett
      <a class="moz-txt-link-rfc2396E" href="mailto:mjg@redhat.com">&lt;mjg@redhat.com&gt;</a>, Holger Macht <a class="moz-txt-link-rfc2396E" href="mailto:holger@homac.de">&lt;holger@homac.de&gt;</a>, Lin
      Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.m.lin@intel.com">&lt;ming.m.lin@intel.com&gt;</a>, Jeff Garzik
      <a class="moz-txt-link-rfc2396E" href="mailto:jgarzik@redhat.com">&lt;jgarzik@redhat.com&gt;</a><br>
      &gt; Cc: <a class="moz-txt-link-abbreviated" href="mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a><br>
      &gt;<br>
      &gt;<br>
      &gt; It's a laptop compaq 2510p (~5 years old core2 laptop) with a
      single SATA drive:<br>
      &gt;<br>
      &gt; 00:1f.1 IDE interface: Intel Corporation 82801HM/HEM
      (ICH8M/ICH8M-E) IDE Controller (rev 03)<br>
      &gt; Subsystem: Hewlett-Packard Company Device 30c9<br>
      &gt; Kernel driver in use: ata_piix<br>
      &gt;<br>
      &gt; kernel v3.5 worked fine. 3.6-rc1 resumes, but disk stays
      inaccessble.<br>
      &gt; Seems to be 100% reproducible. Bisection gave sane result[1].<br>
      &gt;<br>
      &gt; I was not able to revert it as-is, thus couldn't verify the
      revert helps on top of master.<br>
      &gt;<br>
      &gt; Do you need more info?<br>
      &gt;<br>
      &gt; Thanks!<br>
      &gt;<br>
      &gt; [1]<br>
      &gt; commit 30dcf76acc695cbd2fa919e294670fe9552e16e7<br>
      &gt; Author: Matthew Garrett <a class="moz-txt-link-rfc2396E" href="mailto:mjg@redhat.com">&lt;mjg@redhat.com&gt;</a><br>
      &gt; Date: Mon Jun 25 16:13:04 2012 +0800<br>
      &gt;<br>
      &gt; libata: migrate ACPI code over to new bindings<br>
      &gt;<br>
      &gt; Now that we have the ability to directly glue the ACPI
      namespace to the<br>
      &gt; driver model in libata, we don't need the custom code to
      handle the same<br>
      &gt; thing. Remove it and migrate the functions over to the new
      code.<br>
      &gt;<br>
      &gt; Signed-off-by: Matthew Garrett <a class="moz-txt-link-rfc2396E" href="mailto:mjg@redhat.com">&lt;mjg@redhat.com&gt;</a><br>
      &gt; Signed-off-by: Holger Macht <a class="moz-txt-link-rfc2396E" href="mailto:holger@homac.de">&lt;holger@homac.de&gt;</a><br>
      &gt; Signed-off-by: Lin Ming <a class="moz-txt-link-rfc2396E" href="mailto:ming.m.lin@intel.com">&lt;ming.m.lin@intel.com&gt;</a><br>
      &gt; Signed-off-by: Jeff Garzik <a class="moz-txt-link-rfc2396E" href="mailto:jgarzik@redhat.com">&lt;jgarzik@redhat.com&gt;</a><br>
      &gt;<br>
      &gt; :040000 040000 6a659a9d4a92b2085f6d0b58484cb2f82cd12cfa<br>
      &gt; 125fe5d5fa8b208a08792b03e752571d825465d2 M drivers<br>
      &gt; :040000 040000 b7c3819be4e82ae6e2ac9688055aeb2bc1bc4ebd<br>
      &gt; 9cbc8fd15b147a178f723bcdb9e7c34f9868400f M include<br>
      &gt;<br>
      &gt; git bisect good 492d542273a4859f8bf8cc7744cdf71ef50b39ea<br>
      &gt; # bad: [354b2eac3848bddbcb111079138b907ccca70ae8]
      libata-acpi: fix up for acpi_pm_device_sleep_state API git bisect
      bad 354b2eac3848bddbcb111079138b907ccca70ae8<br>
      &gt; # bad: [dc7f71f486f4f5fa96f6dcf86833da020cde8a11]
      sata_dwc_460ex:<br>
      &gt; device tree may specify dma_channel<br>
      &gt; git bisect bad dc7f71f486f4f5fa96f6dcf86833da020cde8a11<br>
      &gt; # bad: [91e4d5a1d7d11ca0b08803a11cb8dc866d2d611f]
      drivers/acpi/glue:<br>
      &gt; revert accidental license-related 6b66d95895c bits git bisect
      bad 91e4d5a1d7d11ca0b08803a11cb8dc866d2d611f<br>
      &gt; # bad: [3bd46600a7a7e938c54df8cdbac9910668c7dfb0]
      libata-acpi: add ata port runtime D3Cold support git bisect bad
      3bd46600a7a7e938c54df8cdbac9910668c7dfb0<br>
      &gt; # bad: [30dcf76acc695cbd2fa919e294670fe9552e16e7] libata:
      migrate ACPI code over to new bindings git bisect bad
      30dcf76acc695cbd2fa919e294670fe9552e16e7<br>
      &gt; # good: [6b66d95895c149cbc04d4fac5a2f5477c543a8ae] libata:
      bind the Linux device tree to the ACPI device tree git bisect good
      6b66d95895c149cbc04d4fac5a2f5477c543a8ae<br>
      &gt; # good: [6b66d95895c149cbc04d4fac5a2f5477c543a8ae] libata:
      bind the Linux device tree to the ACPI device tree git bisect good
      6b66d95895c149cbc04d4fac5a2f5477c543a8ae<br>
      &gt; 30dcf76acc695cbd2fa919e294670fe9552e16e7 is the first bad
      commit<br>
      &gt;<br>
      &gt; --<br>
      &gt;<br>
      &gt; Sergei</span><br>
    <br>
  </body>
</html>

--------------000704080706060008030304--
