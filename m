From: Brad Campbell <brad@wasp.net.au>
Subject: Re: 32 bit s2disk on 64 bit kernel
Date: Fri, 17 Jun 2011 10:52:36 +0800
Message-ID: <4DFAC174.7040904@wasp.net.au>
References: <4DFA1DA5.1010502@wasp.net.au> <201106161958.23398.rjw@sisk.pl>
	<4DFA96CB.8080806@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DFA96CB.8080806@wasp.net.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 17/06/11 07:50, Brad Campbell wrote:
>>> I run an entirely 32 bit userspace on a 64bit kernel. I've compiled suspend-utils from todays git
>>> tree. trying to use s2disk results in the following :
>>>
>>> Is this a supported configuration?
>>
>> No, it isn't.
>
> Hrm.. ok thanks for that. Back to tuxonice I guess.

Scratch that. I compiled up suspend-utils on a 64 bit machine with an added -all-static ld flag and 
it's working great.

I would have thought that with the proliferation of 64 bit procs in laptops that this configuration 
would be more prevalent, but perhaps I'm an oddball.

Regards,
Brad
-- 
Dolphins are so intelligent that within a few weeks they can
train Americans to stand at the edge of the pool and throw them
fish.
