From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 11/15] PM / Hibernate: add chunk i/o support
Date: Fri, 26 Mar 2010 10:09:08 +0100
Message-ID: <4BAC79B4.4040200__19237.3743084774$1269594633$gmane$org@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-11-git-send-email-jslaby@suse.cz>
	<201003252338.48513.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003252338.48513.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/25/2010 11:38 PM, Rafael J. Wysocki wrote:
>> +int sws_rw_buffer_init(int writing)
>> +{
>> +	BUG_ON(sws_writer_buffer || sws_writer_buffer_pos);
> 
> Please don't do that.  Fail the operation instead.  You can also use WARN_ON
> or WARN if you _really_ want the user to notice the failure.

It's not a failure, it's a bug when we leak memory or forgot to
read/write all data.

> BUG_ON's like this are annoying like hell for testers who trigger them.

I think BUG is appropriate here (the system or image is in an
inconsitent state for the latter condition), but if you prefer the
WARN-family here, I can switch it to that.

>> +		if (writing) {
>> +			ret = sws_io_ops->write_page(sws_writer_buffer, NULL);
>> +			clear_page(sws_writer_buffer);
> 
> Why do we need that clear_page()?

Functionally for nothing, it was for my sakeness. Will remove.

>> +int sws_rw_buffer_flush_page(int writing)
>> +{
>> +	int ret = 0;
>> +	if (writing && sws_writer_buffer_pos)
>> +		ret = sws_io_ops->write_page(sws_writer_buffer, NULL);
>> +	sws_writer_buffer_pos = writing ? 0 : PAGE_SIZE;
>> +	return ret;
>> +}
> 
> I'd split the above into two functions, one for writing and the other for
> reading.
> 
> Doing the same with sws_rw_buffer() (under a better name), for the sake of
> clarity, also might make some sense, apparently.

Do you mean adding hib*_buffer_read + hib*_buffer_write which would call
static hib*_rw_buffer? sws_rw_buffer has much common code for R and W,
so I would not make 2 functions from that.

Nigel, you use _rw_ functions in toi, are there any pros opposing to _r_
+ _w_ (apart from exporting twice as symbols)?

thanks,
-- 
js
