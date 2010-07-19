From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 6/9] PM / Hibernate: split snapshot_read_next
Date: Mon, 19 Jul 2010 18:42:32 +0200
Message-ID: <4C448078.206__32315.9991683953$1279558439$gmane$org@gmail.com>
References: <1275468768-28229-1-git-send-email-jslaby@suse.cz>
	<1275468768-28229-6-git-send-email-jslaby@suse.cz>
	<201006251553.28680.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006251553.28680.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/25/2010 03:53 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 02, 2010, Jiri Slaby wrote:
>> When writing the snapshot, do the initialization and header write in
>> a separate function. This makes the code more readable and lowers
>> complexity of snapshot_read_next.
> 
> This one looks good, but it seems to depend on [3/9] and [4/9].  Does it?

Hi, actually I recalled, that this is exactly the reason why I wrote the
3+4/9 crap. (See below.)

>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> ---
>>  kernel/power/power.h    |    2 +
>>  kernel/power/snapshot.c |   65 ++++++++++++++++++++++++++++++----------------
>>  kernel/power/swap.c     |   14 +++-------
>>  3 files changed, 48 insertions(+), 33 deletions(-)
>>
>> diff --git a/kernel/power/power.h b/kernel/power/power.h
>> index 812b66c..ff3f63f 100644
>> --- a/kernel/power/power.h
>> +++ b/kernel/power/power.h
>> @@ -171,6 +171,8 @@ struct hibernate_io_ops {
>>  
>>  extern unsigned int snapshot_additional_pages(struct zone *zone);
>>  extern unsigned long snapshot_get_image_size(void);
>> +extern int snapshot_write_init(struct hibernate_io_handle *io_handle,
>> +		struct snapshot_handle *handle);
>>  extern int snapshot_read_next(struct snapshot_handle *handle);
>>  extern int snapshot_write_next(struct snapshot_handle *handle);
>>  extern void snapshot_write_finalize(struct snapshot_handle *handle);
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index 25ce010..4600d15 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1598,10 +1598,46 @@ pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
>>  }
>>  
>>  /**
>> + *	snapshot_write_init - initialization before writing the snapshot to
>> + *	a backing storage
>> + *
>> + *	This function *must* be called before snapshot_read_next to initialize
>> + *	@handle and write a header.
>> + *
>> + *	@io_handle: handle used when writing the initial info onto storage
>> + *	@handle: snapshot handle to init
>> + */
>> +int snapshot_write_init(struct hibernate_io_handle *io_handle,
>> +		struct snapshot_handle *handle)
>> +{
>> +	int ret;
>> +
>> +	/* This makes the buffer be freed by swsusp_free() */
>> +	buffer = get_image_page(GFP_ATOMIC, PG_ANY);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +	init_header(buffer);
>> +	ret = hib_buffer_init_write(io_handle);
>> +	if (ret)
>> +		return ret;
>> +	ret = hib_buffer_write(io_handle, buffer, sizeof(struct swsusp_info));

If I don't have 3+4/9, I neither have the io_handle and thus cannot use
chunk writer all over the code.

The possibility is to somehow do init_header and storing pfns in user.c
part separately (the same as before these patches) and then remove it
from the code with user.c some time later. The same will hold for
anything we will use chunk writer for and so on.

Is it OK this way?

thanks,
-- 
js
