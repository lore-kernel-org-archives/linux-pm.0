From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Mon, 18 Sep 2006 23:58:04 +0400
Message-ID: <450EFA4C.1070004@gmail.com>
References: <45096933.4070405@gmail.com> <20060918104437.GA4973@elf.ucw.cz> <450E83DC.4050503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751898AbWIRT5f@vger.kernel.org>
In-Reply-To: <450E83DC.4050503@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Eugeny S. Mints" <eugeny.mints@gmail.com>, pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Eugeny S. Mints wrote:
> Pavel Machek wrote:
>> Hi!
>>
[skip]
>> How is it going to work on 8cpu box? will
>> you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?

basically I guess you are asking about what the names of operating points are 
and how to distinguish between operating points from userspace on 8cpu box.

An advantage of PowerOP approach is that operating point name is used as a 
_handle_ and may or may not be meaningful. The idea is that if a policy manager 
  needs to make a decision and needs to distinguish between operating points it 
can check value of any power parameters of operating points in question. Power 
parameter values may be obtained under <op_name> dir name.

With such approach a policy manger may compare operating points at runtime and 
should not rely on compile time knowledge about what name corresponds to  what 
set of power parameter values. It uses name as a handle.

	Eugeny
> 
> i do not operate with term 'state' so I don't understand what it means 
> here.
> 
>     Eugeny
> 
>>                                 Pavel
> 
> 
