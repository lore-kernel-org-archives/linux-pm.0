From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: RE: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Wed, 23 Jan 2008 16:58:12 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801231656350.12676__44305.7241187946$1201104111$gmane$org@fbirervta.pbzchgretzou.qr>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
	<20080121095331.GA5333@infradead.org>
	<05B550FD4BD2014E841D83547B6260080281AE80@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <05B550FD4BD2014E841D83547B6260080281AE80@bgsmsx411.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Jan 21 2008 19:49, Thomas, Sujith wrote:
>>> 
>>> +MODULE_AUTHOR("Thomas Sujith");
>>> +MODULE_AUTHOR("Zhang Rui");
>> 
>> I've never seen a driver with two MODULE_AUTHOR statements before.
>> Does this actually work?  What does modinfo -F author say for your module?
>
>There is nothing wrong in giving 2 MODULE_AUTHORS. Both will be
>displayed in the command modinfo -F author.

Coding-wise, it is no problem. MODULE_* gets transformed into char
__mod_*line, so as long as you have the two MODULE_AUTHOR() macros on
different lines, it will work.

It is cool to actually see this working out-of-the-box with modinfo
too (even without the -F option). Could decouple a few AUTHOR lines.
