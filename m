From: Jiri Slaby <jirislaby@gmail.com>
Subject: Can't s2ram 22-rc2 [Was: 2.6.22-rc2 BUG: at
	slub_def.h:77]
Date: Mon, 21 May 2007 10:38:21 +0200
Message-ID: <46515A7D.20003@gmail.com>
References: <1179728579.11803.1.camel@localhost>	 <465153AF.5030008@gmail.com>
	<1179736498.4980.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1179736498.4980.1.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Played with Cc list.

Soeren Sonnenburg napsal(a):
> On Mon, 2007-05-21 at 10:09 +0200, Jiri Slaby wrote:
>> Soeren Sonnenburg napsal(a):
>>> a regression (well I switched to slub) happens on boot...
> 
>>> BUG: at include/linux/slub_def.h:77 kmalloc_index()
>>>  [<c0176448>] get_slab+0x1c8/0x250
> [...]
>> Could you try this patch:
>> http://lkml.org/lkml/2007/5/19/171
> 
> yes, that does fix the issue (at least I don't see the BUG: anymore on
> boot). however I can no longer s2ram on 22rc2. 

Whit what kind of error or what happens?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
