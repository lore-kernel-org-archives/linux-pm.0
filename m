From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Mon, 6 Aug 2012 10:36:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208061028160.1649-100000@iolanthe.rowland.org>
References: <20120806102114.GA31404@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120806102114.GA31404@elf.ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Vasilyev <pavel@pavlinux.ru>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Aug 2012, Pavel Machek wrote:

> On Thu 2012-07-26 21:39:38, Len Brown wrote:
> > ...both give the number of chars in the string
> > without the '\0', as strncmp() wants,
> > but sizeof() is compile-time.
> 
> What about introducing something like streq() to do this
> automatically? This is ugly....
> 
> #define streq(a, b) ... if (_buildin_constant(b)) ...
> 
> ?
> 
> > -	if (!strncmp(val, "enable", strlen("enable"))) {
> > +	if (!strncmp(val, "enable", sizeof("enable") - 1)) {

While you're at it, there's no point using strncmp when you know the 
length of one of the strings beforehand.  Just use memcmp, and don't 
subtract 1 from the sizeof value.

Alan Stern
