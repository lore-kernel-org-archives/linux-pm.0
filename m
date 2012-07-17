From: John Stultz <johnstul@us.ibm.com>
Subject: Re: [Regression][Revert request] Excessive delay or hang
 during resume from system suspend due to a hrti
Date: Mon, 16 Jul 2012 18:55:16 -0700
Message-ID: <5004C604.8040308@us.ibm.com>
References: <CA+icZUXURRAs-rK1EnRidYUQ9NXXYw4DaHbn=4mcEe3Q0sU+2A@mail.gmail.com>
	<CA+icZUWUhZpRKU5rO+m4Xe1DNLYAq8NPBCS_B2c3Kmgq+gBQ3w@mail.gmail.com>
	<5004553A.2060104@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5004553A.2060104@us.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: sedat.dilek@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On 07/16/2012 10:54 AM, John Stultz wrote:
>
> Thanks for sending your config and test results.
>
> Looking at the call trace you provided, I'm not seeing anything yet, 
> but I'll be looking over the code while running my test boxes in a 
> reboot loop w/ your config to see if I can't figure out the 
> get_next_timer_interrupt issue you saw at bootup.

Left my two boxes (one bare-metal, the other a VM) in reboot loops all 
day with your config and haven't hit anything. :(

Do let me know if you're able to trigger this again. Given that the back 
trace you listed doesn't seem to be directly linked to the leapsecond 
related hrtimer changes, I'm wondering if this might be something else.

But if you get any more details, do let me know and I'll try to sort it out.

thanks
-john
