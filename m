From: Hans Wennborg <hans@hanshq.net>
Subject: Re: [PATCH 02/15] cpufreq: fix decimal printf format specifiers prefixed
 with 0x
Date: Wed, 06 Aug 2014 22:53:38 -0700
Message-ID: <53E31462.2060800@hanshq.net>
References: <1407300108-32186-1-git-send-email-hans@hanshq.net> <1494298.av10nJMuYA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494298.av10nJMuYA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/06/2014 01:35 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 05, 2014 09:41:48 PM Hans Wennborg wrote:
>> The prefix suggests the number should be printed in hex, so use
>> the %x specifier to do that.
>>
>> Found by using regex suggested by Joe Perches.
>>
>> Signed-off-by: Hans Wennborg <hans@hanshq.net>
>
> This triggers a build warning related to the formats.  Care to fix up?

Sure. Sending a new patch, hopefully attached to the same thread (still 
working on my git send-mail skills).

  - Hans
