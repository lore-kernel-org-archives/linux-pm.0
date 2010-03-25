From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 03/15] PM / Hibernate: separate block_io
Date: Fri, 26 Mar 2010 07:13:05 +1100
Message-ID: <4BABC3D1.1050104__38798.0261737995$1269548002$gmane$org@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<4BAA98FC.9040302@crca.org.au> <4BAACC0A.2040009@crca.org.au>
	<201003252112.25204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003252112.25204.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On 26/03/10 07:12, Rafael J. Wysocki wrote:
> On Thursday 25 March 2010, Nigel Cunningham wrote:
>> Hi again.
>>
>> On 25/03/10 09:58, Nigel Cunningham wrote:
>>> Hi.
>>>
>>> On 25/03/10 08:22, Jiri Slaby wrote:
>>>> On 03/24/2010 09:30 PM, Pavel Machek wrote:
>>>>> On Tue 2010-03-23 17:17:31, Jiri Slaby wrote:
>>>>>> +int sws_bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
>>>>>> +{
>>>>>> +	return submit(READ, sws_resume_bdev, page_off * (PAGE_SIZE>>    9),
>>>>>> +			virt_to_page(addr), bio_chain);
>>>>>> +}
>>>>>
>>>>> sws_ is kind of strange prefix. We were trying to get away from
>>>>> "swsuspend" name for quite some time...
>>>>
>>>> No problem to change the prefix to anything else. Do you (anybody)
>>>> suggest anything?
>>>>
>>>
>>> How about some abbreviation of hibernate? "hib"?
>>
>> On further reflection, how about "std" (suspend to disk)? I think that's
>> less ugly than the 'hib' suggestion :)
>
> But it also decodes as "standard" if someone is not in the right context. :-)

Ah...

> If the "bio" part of the name is not essential (ie. there's no conflicting name
> already), we could call it simply hibernate_read_page().

Yeah. So we're going with hibernate or hib_ if it needs abbreviating?

Nigel
