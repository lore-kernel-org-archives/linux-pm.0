From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during	snapshot/shutdown
Date: Sat, 28 Apr 2007 11:26:56 +0300
Message-ID: <46330550.8020005@cs.helsinki.fi>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>	
	<20070427145212.GO22250@elf.ucw.cz>	
	<1177709523.4737.157.camel@nigel.suspend2.net>	
	<20070427221234.GE2994@elf.ucw.cz>	
	<1177712296.4737.182.camel@nigel.suspend2.net>	
	<20070427222543.GF2994@elf.ucw.cz>
	<1177715134.4737.194.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177715134.4737.194.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@nigel.suspend2.net
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Nigel Cunningham wrote:
> I therefore have to ask: Please. Go away. Hand the maintainership of
> hibernation over to Rafael. Work on things you do care about and where
> you do want to see a fully functional implementation. But stop being a
> hindrance to us making Linux hibernation support everything that it
> ought to be.

[snip]

Please. The load average is a problem and no the fix is not to make 
kernel/timer.c worse for everybody but to snapshot the load averages 
_before_ I/O and restore them after resume.

So can we please drop the drama? Pretty please? And sugar on the top? 
Thank you.

			Pekka
