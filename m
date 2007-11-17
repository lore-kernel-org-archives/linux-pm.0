From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sat, 17 Nov 2007 16:12:11 +0100
Message-ID: <473F04CB.70602__16021.4781914421$1195312404$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0711161058170.2738-100000@iolanthe.rowland.org>
	<473F03DF.4020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <473F03DF.4020306@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/17/2007 04:08 PM, Jiri Slaby wrote:
> On 11/16/2007 05:10 PM, Alan Stern wrote:
>> If there's also a config 
>> option to prevent the console from being suspended, set it as well.  
> 
> no_suspend_console kernel parameter has no effect (why?).

Eh, no, this (/proc/cmdline):
ro root=/dev/md1 reboo1 vga=1 2 no_console_suspend

regards,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
