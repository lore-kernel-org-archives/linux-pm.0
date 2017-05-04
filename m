From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] x86/intel_idle: add GLK support
Date: Thu, 4 May 2017 16:35:13 -0700
Message-ID: <20170504163513.2a66009b@jacob-builder>
References: <20170423060625.4593-1-david.e.box@linux.intel.com>
        <5173906.Kty4Ih4RO9@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62236 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbdEDXeF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 19:34:05 -0400
In-Reply-To: <5173906.Kty4Ih4RO9@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "David E. Box" <david.e.box@linux.intel.com>, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Thu, 27 Apr 2017 00:36:42 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> > From: "Box, David E" <david.e.box@intel.com>
> > 
> > Gemini Lake uses the same C-states as Broxton and also uses the
> > IRTL MSR's to determine maximum C-state latency.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>  
> 
> You could use the code names consistently in your subjects (but I can
> fix this up).
> 
> Jacob, any concerns?

No. Sorry for the delay.
Acked-by: Pan, Jacob jun <jacob.jun.pan@intel.com>
