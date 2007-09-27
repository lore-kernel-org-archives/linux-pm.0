From: roel <12o3l@tiscali.nl>
Subject: Re: [RFC] QoS params patch
Date: Thu, 27 Sep 2007 15:00:14 +0200
Message-ID: <46FBA95E.3090207__32394.1788556569$1190904098$gmane$org@tiscali.nl>
References: <20070926223712.GA22029@linux.intel.com>
	<20070926224026.GA23218@linux.intel.com>
	<20070926164159.3b43479b.randy.dunlap@oracle.com>
	<20070927004020.GB29906@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070927004020.GB29906@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mgross@linux.intel.com
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Mark Gross wrote:
> On Wed, Sep 26, 2007 at 04:41:59PM -0700, Randy Dunlap wrote:
>> On Wed, 26 Sep 2007 15:40:26 -0700 Mark Gross wrote:
>>
>>> The following is the qos_param patch that implements a genralization of
>>> latency.c.
>>>
>> Just some general comments (as on irc):
>>
>> - use 'diffstat -p1 -w70' to summarize each patch
>> - use checkpatch.pl to check for coding style and other buglets
> 
> done
> 
>> - has no API docs  :(
> not done yet.
>>
>>
>>
>>> +/* assumes qos_lock is held */
>>> +static void update_target(int i)
>> I'd prefer a better arg name than 'i'.
> 
> I do too, but i in this case is an Index.

I think in many cases you could use a pointer to qos_array[i] instead of 
passing this index 'i' as a function argument.

Roel
