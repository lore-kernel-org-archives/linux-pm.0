From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 03/15] PM / Hibernate: separate block_io
Date: Thu, 25 Mar 2010 15:29:44 +0100
Message-ID: <20100325142943.GA1657__13897.5985850722$1269527487$gmane$org@ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-3-git-send-email-jslaby@suse.cz>
	<20100324203021.GE5798@elf.ucw.cz> <4BAA829F.7060207@gmail.com>
	<4BAA98FC.9040302@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BAA98FC.9040302@crca.org.au>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2010-03-25 09:58:04, Nigel Cunningham wrote:
> Hi.
>
> On 25/03/10 08:22, Jiri Slaby wrote:
>> On 03/24/2010 09:30 PM, Pavel Machek wrote:
>>> On Tue 2010-03-23 17:17:31, Jiri Slaby wrote:
>>>> +int sws_bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
>>>> +{
>>>> +	return submit(READ, sws_resume_bdev, page_off * (PAGE_SIZE>>  9),
>>>> +			virt_to_page(addr), bio_chain);
>>>> +}
>>>
>>> sws_ is kind of strange prefix. We were trying to get away from
>>> "swsuspend" name for quite some time...
>>
>> No problem to change the prefix to anything else. Do you (anybody)
>> suggest anything?
>>
>
> How about some abbreviation of hibernate? "hib"?

hib_ certainly sounds better.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
