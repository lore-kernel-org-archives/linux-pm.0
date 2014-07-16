From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / devfreq: Allocate memory using the right data type
Date: Tue, 15 Jul 2014 20:33:42 -0700
Message-ID: <20140716033342.GA31052@kroah.com>
References: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Suman Tatiraju <sumant@codeaurora.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 15, 2014 at 08:10:43PM -0700, Saravana Kannan wrote:
> From: Suman Tatiraju <sumant@codeaurora.org>
> 
> Long and int have different sizes on a 64-bit machine. Allocate
> memory for the time_in_state table using the right data type.
> 
> Change-Id: I335277674018c0ea759aa0996309d52578ea1fd5

Please don't put this crud in patches you submit upstream.  It means
nothing to us.

> Signed-off-by: Suman Tatiraju <sumant@codeaurora.org>
> Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/devfreq/devfreq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
