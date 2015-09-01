From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 0/2] Fixes for cpu cooling
Date: Tue, 1 Sep 2015 09:31:48 +0100
Message-ID: <20150901083148.GA2730@e104805>
References: <1439835703-16470-1-git-send-email-javi.merino@arm.com>
 <20150825185347.GB2708@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150825185347.GB2708@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 25, 2015 at 07:53:48PM +0100, Javi Merino wrote:
> On Mon, Aug 17, 2015 at 07:21:41PM +0100, Javi Merino wrote:
> > Commit c36cf0717631 ("thermal: cpu_cooling: implement the power
> > cooling device API") introduced two bugs: a call to kcalloc() (that
> > might sleep) under RCU and not freeing the allocation when it's no
> > longer needed.  This series fixes both issues.
> > 
> > Javi Merino (2):
> >   thermal: cpu_cooling: don't call kcalloc() under rcu_read_lock
> >   thermal: cpu_cooling: free power table on error or when unregistering
> 
> Gentle ping

Another ping
