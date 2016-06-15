From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: Use conventional shared library versioning
Date: Wed, 15 Jun 2016 13:03:14 +0200
Message-ID: <2753168.d7n2N2ZaIy@skinner>
References: <20160610010554.GR7555@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48760 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcFOLDQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 07:03:16 -0400
In-Reply-To: <20160610010554.GR7555@decadent.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-pm@vger.kernel.org

Hi Ben,

On Friday, June 10, 2016 02:05:54 AM Ben Hutchings wrote:
> The current choice of variable names is rather confusing.  LIB_MIN is
> used for the soname version, which would normally be the *major* part
> of the version.
> 
> - Rename LIB_MAJ (the full version) to LIB_VER and LIB_MIN (the soname
>   version) to LIB_SONAME_VER
> - Define LIB_SONAME_VER to be the first component of LIB_VER
> - Bump the full version to 1.0.0, since the soname version is currently 1

I am currently working on adding rapl/powercapping things into
cpupower.
I will collect/integrate your patches and send them altogether.

Thanks,

      Thomas
