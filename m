From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 08:34:50 +0300 (EEST)
Message-ID: <20100715.083450.193689911.Hiroshi.DOYU__36424.2107062184$1279172261$gmane$org@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<20100714132255.GB3103@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100714132255.GB3103@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, pavel@ucw.cz
Cc: teerth@ti.com, linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: ext Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Wed, 14 Jul 2010 15:22:55 +0200

> Hi!
> 
>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> 
>> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>> 
>> Based on the original work from Romit and Raghu at TI. The original
>> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>> 
>> *1: https://patchwork.kernel.org/patch/96442/
>> 
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Looks ok to me. ACK.

Pavel, Thanks.

Russell, would it be possible to put this into your next merge queue?
