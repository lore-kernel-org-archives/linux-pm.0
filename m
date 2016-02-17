From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: Fix build error in cpufreq-info
Date: Wed, 17 Feb 2016 15:29:45 +0100
Message-ID: <5255546.ocxDsFsmcy@skinner>
References: <1453130083-16055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37862 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423215AbcBQO3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 09:29:47 -0500
In-Reply-To: <1453130083-16055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com, jtanenba@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, January 18, 2016 08:44:43 PM Shreyas B. Prabhu wrote:
> Fix the following build error by including limits.h -
>=20
> utils/cpufreq-info.c: In function =E2=80=98get_latency=E2=80=99:
> utils/cpufreq-info.c:437:29: error: =E2=80=98UINT_MAX=E2=80=99 undecl=
ared (first use in
> this function)
>   if (!latency || latency =3D=3D UINT_MAX) {
>                              ^
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Signed-off-by: Thomas Renninger <trenn@suse.com>

Builds for me by luck, thanks!


       Thomas
