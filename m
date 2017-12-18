From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: list_del_rcu should be used in function
 _remove_list_dev
Date: Mon, 18 Dec 2017 15:10:31 +0530
Message-ID: <20171218094031.GK19815@vireshk-i7>
References: <20171218083223.26647-1-chunyan.zhang@spreadtrum.com>
 <20171218090747.GB10436@kroah.com>
 <20171218091139.GJ19815@vireshk-i7>
 <20171218093221.GA25991@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218093221.GA25991@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Wang <vincent.wang@spreadtrum.com>, Orson Zhai <orson.zhai@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18-12-17, 10:32, Greg Kroah-Hartman wrote:
> > > > Cc: stable <stable@vger.kernel.org>     # 4.4

> Yes, that too.  But the most basic issue of not cc: stable@vger is also
> a problem here :(

I completely missed that as Cc was marked inside the commit :)

-- 
viresh
