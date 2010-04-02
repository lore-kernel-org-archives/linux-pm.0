From: Pavel Machek <pavel@ucw.cz>
Subject: Re: what the patches do Re: [RFC 10/15] PM /
	Hibernate:	user, implement user_ops reader
Date: Fri, 2 Apr 2010 08:36:45 +0200
Message-ID: <20100402063644.GA14941__35068.9553110444$1270190276$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003252114.36605.rjw@sisk.pl> <4BABC5B6.2070301@crca.org.au>
	<201003252129.10224.rjw@sisk.pl>
	<20100325212656.GD22902@elf.ucw.cz> <4BABDA59.8070107@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BABDA59.8070107@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi!

>>>> So what's your long term plan then?
>>>
>>> First, improve the in-kernel thing, second, switch people to it, _then_ remove
>>> the s2disk interface (after we're reasonably sure it's not used by any major
>>> distro) and _finally_ simplify things after it's been removed.
>>
>> I'd really prefer to keep s2disk interface. It allows advanced stuff
>> like internet suspend resume (yep someone is doing it), crazy stuff
>> like multiple resumes from same image for fast booting (yep, some
>> embedded people are doing that) and might-be-useful stuff like
>> s2both...
>
> Neither of those are impossible with in-kernel code, so I'd argue that  
> there's no need to keep the s2disk interface long-term. Userspace  

I disagree.

> helpers might be necessary for the first one (to manage the network  
> interface), but I already have multiple-resumes-from-the-same-image  
> support in TuxOnice (and more 'crazy stuff' like support for resuming a  
> different image after writing one - that can be used to switch to an  
> initramfs containing the binaries needed to power down a UPS).

The fact that it can be done in kernel -- anything can -- but whether
it should. I'd very much like to keep the 'crazy stuff' in userspace.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
