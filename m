From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Wed, 2 Jan 2008 12:29:42 -0800
Message-ID: <200801021229.43555.david-b__16365.1500283324$1199305986$gmane$org@pacbell.net>
References: <200801020032.45529.rjw@sisk.pl>
	<20080102175400.3C2E0EF588@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080102201451.GC3985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080102201451.GC3985@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: a.zummo@towertech.it, gregkh@suse.de, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 January 2008, Ingo Molnar wrote:
> 
> then please provide a kernel config option for the new driver to take 
> over 10:135 too. There's nothing worse to the adoption of new kernel 
> features necessiating user-space attention. I've got several images of 
> old distros that i dont want to reconfigure in any way, and it would be 
> nice to have a drop-in /dev/rtc replacement for them. Really. This is 
> how we do it for just about everything else too.

I'll let someone else chase that particular issue.  :)
