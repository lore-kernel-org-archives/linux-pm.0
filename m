From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: of: fix cleanup when building a thermal zone
Date: Mon, 28 Mar 2016 06:43:50 -0700
Message-ID: <20160328134349.GC7624@localhost.localdomain>
References: <1458935741-21355-1-git-send-email-brindisu@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458935741-21355-1-git-send-email-brindisu@lab126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulises Brindis <brindisu@lab126.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 25, 2016 at 12:55:41PM -0700, Ulises Brindis wrote:
> of_node_put is iterating through all terms in the tbps array even though
> the bind has failed. We need to only iterate through the terms that have
> already passed the binding step.

Thanks for your patch. Queueing into my -fixes branch.
