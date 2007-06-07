From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Thu, 07 Jun 2007 23:05:08 +0900
Message-ID: <46681094.4070103@gmail.com>
References: <46608E3F.4060201@dgreaves.com> <46609FAD.7010203@dgreaves.com>	 <200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com>	 <alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org>	 <4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com>	 <46668EE0.2030509@dgreaves.com> <46679D56.7040001@gmail.com>	 <4667DE2D.6050903@dgreaves.com> <e9e943910706070645p29519138i7e76b3a9649d387@mail.gmail.com> <46680F69.60105@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761700AbXFGOFd@vger.kernel.org>
In-Reply-To: <46680F69.60105@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Duane Griffin <duaneg@dghda.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, xfs@oss.sgi.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>
List-Id: linux-pm@vger.kernel.org

David Greaves wrote:
> Duane Griffin wrote:
>> On 07/06/07, David Greaves <david@dgreaves.com> wrote:
>>> > How hard does the machine freeze?  Can you use sysrq?  If so, please
>>> > dump sysrq-t.
>>> I suspect there is a problem writing to the consoles...
>>>
>>> I recompiled (rc4+patch) with sysrq support, suspended, resumed and
>>> tried
>>> sysrq-t but got no output.
>>>
>>> I *can* change VTs and see the various login prompts, bitmap messages
>>> and the
>>> console messages. Caps/Num lock lights work.
>>>
>>> Fearing incompetence I tried sysrq-s sysrq-u sysrq-b and got a reboot
>>> so sysrq
>>> is OK.
>>
>> Try sysrq-9 before the sysrq-t. Probably the messages are not being
>> printed to console with your default output level.
> 
> Good idea :)
> Didn't work :(

Can you setup serial console and/or netconsole (not sure whether this
would work tho)?

-- 
tejun
