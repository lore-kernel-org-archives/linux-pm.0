From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
Date: Fri, 21 Feb 2014 22:44:28 +0100
Message-ID: <20140221214428.GJ19285@linux-mips.org>
References: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 17, 2014 at 11:09:45AM -0500, Nicolas Pitre wrote:

> I noticed commit c0b5d598aefda in linux-next adds a call to 
> cpuidle_idle_call().  At the same time we're rationalizing the idle 
> handling code in order to integrate it with the scheduler proper.  
> Please note that a similar patch to the one below will be necessary once 
> everything gets merged together.

So how shall we merge this patch, shall I fold it into c0b5d598aefda or?

  Ralf
