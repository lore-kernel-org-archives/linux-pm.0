From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] bus: subsys: propagate errors from subsys interface's
 ->add_dev()
Date: Thu, 30 Jul 2015 08:55:59 +0530
Message-ID: <20150730032559.GG5100@linux>
References: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org>
 <20150729211916.GA11972@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150729211916.GA11972@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, pi-cheng.chen@linaro.org, "3.3+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29-07-15, 14:19, Greg KH wrote:
> I don't see how this is a stable bug fix, what is resolved by it that
> doesn't work today?  Is there some code that is expecting this
> functionality that has never been present?
> 
> I'll go queue it up, but I don't think it is -stable material, but feel
> free to change my mind.

Yeah, probably its a bit overdone. Leave the stable thing for now..

-- 
viresh
