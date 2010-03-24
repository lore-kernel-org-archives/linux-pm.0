From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC 03/15] PM / Hibernate: separate block_io
Date: Thu, 25 Mar 2010 09:58:04 +1100
Message-ID: <4BAA98FC.9040302__49290.4013874524$1269474040$gmane$org@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-3-git-send-email-jslaby@suse.cz>
	<20100324203021.GE5798@elf.ucw.cz> <4BAA829F.7060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BAA829F.7060207@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi.

On 25/03/10 08:22, Jiri Slaby wrote:
> On 03/24/2010 09:30 PM, Pavel Machek wrote:
>> On Tue 2010-03-23 17:17:31, Jiri Slaby wrote:
>>> +int sws_bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
>>> +{
>>> +	return submit(READ, sws_resume_bdev, page_off * (PAGE_SIZE>>  9),
>>> +			virt_to_page(addr), bio_chain);
>>> +}
>>
>> sws_ is kind of strange prefix. We were trying to get away from
>> "swsuspend" name for quite some time...
>
> No problem to change the prefix to anything else. Do you (anybody)
> suggest anything?
>

How about some abbreviation of hibernate? "hib"?

Regards,

Nigel
