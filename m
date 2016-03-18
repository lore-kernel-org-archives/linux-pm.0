From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] powercap: intel_rapl: PSys support
Date: Fri, 18 Mar 2016 10:09:28 +0100
Message-ID: <20160318090928.GB7889@pd.tnic>
References: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160317225100.GA3805@pd.tnic>
 <1458255363.3861.40.camel@linux.intel.com>
 <20160317185532.7ab0adc5@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42286 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbcCRJJd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 05:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20160317185532.7ab0adc5@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org

On Thu, Mar 17, 2016 at 06:55:32PM -0700, Jacob Pan wrote:
> I think it could be used by perf rapl pmu also, but later.

Once that happens, you can move them to msr-index.h, of course.

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--=20
