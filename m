From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook
 for disable/enable nonboot cpus
Date: Sun, 26 Jun 2016 01:19:10 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402877B7E5@shsmsx102.ccr.corp.intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <fb78859e5c1ea061ce4e35e200821ed170e6658d.1466844557.git.yu.c.chen@intel.com>
 <20160625165159.GB4362@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7597 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbcFZBTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2016 21:19:15 -0400
In-Reply-To: <20160625165159.GB4362@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,


> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Sunday, June 26, 2016 12:52 AM
> To: Chen, Yu C
> Cc: linux-pm@vger.kernel.org; x86@kernel.org; Rafael J. Wysocki; Len Brown;
> Peter Zijlstra; H. Peter Anvin; Borislav Petkov; Brian Gerst; Thomas Gleixner;
> Ingo Molnar; Varun Koyyalagunta; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/4][RFC v2] PM / sleep: Introduce arch-specific hook for
> disable/enable nonboot cpus
> 
> On Sun 2016-06-26 00:18:41, Chen Yu wrote:
> > There is requirement that we need to do some arch-specific operations
> > before putting the nonboot CPUs offline/online.
> > One of the requirements comes from the hibernation resume process on
> > x86_64, we need to kick all the offlin-CPUs online and offline again,
> > in order to put them in a safe state, thus to avoid possible unwilling
> > wake up during hibernation resume.
> 
> You may want to check english here.
Ah, sorry, I'll rewrite the log, and [PATCH 4/4] might contain the detail of this issue.

thanks,
Yu
