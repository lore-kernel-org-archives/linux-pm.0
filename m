From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 14:57:21 -0700
Message-ID: <20160714215721.GD3057@ubuntu>
References: <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
 <20160714005524.GA517@swordfish>
 <CAJZ5v0ggjER5soi35bvNHTxGLYK7pie_DxtZKQHSvdH6wFf9AA@mail.gmail.com>
 <20160714013215.GB517@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160714013215.GB517@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>, Petr Mladek <pmladek@suse.com>
List-Id: linux-pm@vger.kernel.org

On 14-07-16, 10:32, Sergey Senozhatsky wrote:
> it wouldn't really, this silly question was not directly related to the
> deadlock we are discussing here but to Viresh's argument that later stages
> of suspending/hibernation seem to printk many messages in sync mode. so I
> thought that there might be a small benefit in suspending consoles later,
> as far as I understand, Viresh has `no_console_suspend' anyway. other

That option is enabled only for testing though :)

> than that, I tend to stick to the approach of switching to sync mode from
> suspend_console().

I actually need to test it out as well :)

-- 
viresh
