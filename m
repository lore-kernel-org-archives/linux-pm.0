From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update 2x][PATCH 7/7] cpufreq: Separate CPU device registration
 from CPU online
Date: Wed, 29 Jul 2015 19:37:35 +0530
Message-ID: <20150729140735.GE5100@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <1739669.kedIsxdRK2@vostro.rjw.lan>
 <1702607.RH80fBCN6J@vostro.rjw.lan>
 <3091538.g8dYBumqSx@vostro.rjw.lan>
 <20150729053248.GC21493@linux>
 <CAJZ5v0h7MiSJ+Sus1g8prBN3O6y98JDUPBQ=vjCQ1KG_yP22+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h7MiSJ+Sus1g8prBN3O6y98JDUPBQ=vjCQ1KG_yP22+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 29-07-15, 16:02, Rafael J. Wysocki wrote:
> You'd still need policy, so its definition and initialization would stay there.
> 
> The only thing you can save by doing that change is the ret variable,
> but I like the code more the way it is.

Okay, that's fine.

-- 
viresh
