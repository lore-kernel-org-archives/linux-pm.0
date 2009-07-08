From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Patch 2/2: Add compression support to swsusp.
Date: Wed, 08 Jul 2009 18:16:09 +1000
Message-ID: <4A5455C9.2050708__37252.9956898235$1247041107$gmane$org@crca.org.au>
References: <4A518FBD.7050102@crca.org.au> <20090708080331.GA13403@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090708080331.GA13403@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

Pavel Machek wrote:
>> @@ -437,7 +439,7 @@ static int enough_swap(unsigned int nr_pages)
>>  	unsigned int free_swap = count_swap_pages(root_swap, 1);
>>  
>>  	pr_debug("PM: Free swap pages: %u\n", free_swap);
>> -	return free_swap > (nr_pages + PAGES_FOR_IO) * 1.01;
>> +	return free_swap > (nr_pages + PAGES_FOR_IO) * .6;
>>  }
>>  
>>  /**
> 
> This is buggy and was buggy before. We may not use floating point in
> kernel...

Yeah. Already rewritten. I was trying to simplify things for swsusp, but
decided I should just do it right first time.

Regards,

Nigel
