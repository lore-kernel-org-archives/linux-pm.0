From: U Kuehn <ukuehn@acm.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 07 May 2009 18:55:54 +0200
Message-ID: <4A03129A.90105__1513.37953652746$1241718120$gmane$org@acm.org>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507120948.GA1531@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>> To briefly summarise the advantages to merging TuxOnIce:
>>
>> - Support for multiple swap devices
>> - Support for non-swap (an ordinary file can be used)
>> - Uses cryptoapi (LZO support, more than 2x speed of uncompressed data!)
>> - Asynchronous I/O, readahead, multithreaded. Get the maximum throughput
>>   possible with your hardware.
>> - Userspace user interface that lets you abort hibernating and abort
>>   resuming, get nice progress display etc.
> 
> All these are either done by uswsusp already, or could be done w/o
> modifying kernel code.
> 

Given that tuxonice DOES work reliably with dm-crypt encrypted swap
partitions, does uswsusp offer this functionality? Looking into the docs
on the sourceforge site does not give any information about this point.

Further, being someone with a crypto background, the userland suspend
helper does have some issues with the password/key handling:
1) no support for keys containing a 0 byte. (cryptsetup can handle this)
2) the rsa functionality seems to use the unsound practice to encrypt
the symmetric key directly without any padding (aka encoding in libgcrypt).

This is, unfortunately, something really fundamenta...

Just to add my 2 cents...

Ulrich
