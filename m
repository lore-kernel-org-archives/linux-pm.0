From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/9] PM / Hibernate: swap,
	switch to hibernate_io_handle
Date: Mon, 21 Jun 2010 17:23:23 +0200
Message-ID: <4C1F83EB.8060703__8121.38752448863$1277133945$gmane$org@gmail.com>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<20100610135541.GB4514@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100610135541.GB4514@ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/10/2010 03:55 PM, Pavel Machek wrote:
> It would be good if you carried ack-s from previous rounds, so that I
> don't have to review good patches again...

Hi, previously ACKed patches were merged already. These were much
rewritten and their original versions were rather NACKed. Otherwise I
transfer ACKs indeed.

>> +/**
>> + * hib_io_handle_alloc - allocate io handle with priv_size for private data
>> + *
>> + * @priv_size: the sie to allocate behind hibernate_io_handle for private use
>> + */
>> +static inline struct hibernate_io_handle *hib_io_handle_alloc(size_t priv_size)
>> +{
>> +	struct hibernate_io_handle *ret;
>> +	ret = kzalloc(sizeof(*ret) + priv_size, GFP_KERNEL);
>> +	if (ret)
>> +		ret->priv = ret + 1;
> 
> Uhuh, why this? Aha, grabbing the pointer to priv_size-sized area at
> the end of regular struct?

Yes, exactly, any more transparent way to do it?

-- 
js
