From: Betty Dall <betty.dall@hp.com>
Subject: Re: turbostat tool update for Linux-3.8
Date: Thu, 15 Nov 2012 13:37:54 -0700
Message-ID: <1353011874.3055.22.camel@ejdallLaptop>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-11-14 at 15:43 -0500, Len Brown wrote:
> Here are some turbostat patches I have staged.
> The 1st two I've requested be pulled into 3.7,
> the rest are for 3.8
> 
> The final patch allows turbostat to print Watts
> as measured by hardware RAPL counters -- something
> that people have been asking for.
> 
> Please let me know if you see troubles with any of these patches.

Hi Len,

I tested out these patches on an IvyBridge system and see the new Watts
fields. They look like reasonable numbers to me. I ran with the system
idle and then with lookbusy -c 50 and saw the Watts increase. Is there
anything else to do to validate the numbers? In one case I saw that the
Pkg_W for the system was off by .01, e.g. socket 0 was 28.33 and socket
1 was 29.74 and the system total was 58.08 instead of 58.07. That is
probably fine and just rounding up.

-Betty
