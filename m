From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/9] cpufreq: Introduce support for ST's cpufreq
 functionality
Date: Wed, 8 Jul 2015 11:59:58 +0100
Message-ID: <20150708105958.GO3182@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <20150708105054.GB1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34863 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337AbbGHLAF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 07:00:05 -0400
Received: by wiga1 with SMTP id a1so281543442wig.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 04:00:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150708105054.GB1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Wed, 08 Jul 2015, Viresh Kumar wrote:

> On 24-06-15, 14:58, Lee Jones wrote:
> > This driver reads very platform specific information in from Device=
 Tree
> > and translates it into frequency tables.  The generic drivers then =
use the
> > tables to conduct frequency and voltage scaling in the normal way.
> >=20
> > There are 'ARM' patches in the set which are not necessarily relate=
d to CPUFreq,
> > but are required to get it to work.  Anyone who is not interested i=
n general STi
> > DT changes can safely ignore these.
> >=20
> > v1 =3D> v2:
> >  - CPUFreq is no longer it's own device in DT; instead:
> >    - It is probed from the platform area
> >    - Key properties have been moved into the CPU's node
> >  - Driver is less generic [ST =3D> STI]
> >  - Documentation has been updated
> >    - Point one (above) has been accounted for
> >    - Example of bootloader supplied node has been provided
> >  - GPL licensing has been updated to reflected the header
> >  - Kconfig disparity has been rectified [bool =3D> tristate]
>=20
> Sorry for being so late to get back to this.. Was tooo busy :(

No problem.  So long as it's still on your radar.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
