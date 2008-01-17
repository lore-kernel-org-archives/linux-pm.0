From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Thu, 17 Jan 2008 12:51:39 -0800
Message-ID: <478FBFDB.4000600__30768.3980711319$1200603225$gmane$org@oracle.com>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
	<20080117092030.a9dfe528.randy.dunlap@oracle.com>
	<200801171451.18613.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171451.18613.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, sujith.thomas@intel.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Len Brown wrote:
>>> +static int
>>> +memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
>>> +			     unsigned long *max_state)
>> Don't put 'static int' (return type etc.) on a line by itself.
>> That format is not wanted in Linux.   (many places here)
> 
> if checkpatch.pl and Lindent are happey (which they are not, totally)
> then I'm satisifed witht he Linux style of the code.
> 
> Randy, if you feel strongly about this this style nit,
> then change Lindent to implement it -- nagging
> developers about trivia is a waste of everybody's time.
> 
> thanks,
> -Len

http://marc.info/?l=linux-kernel&m=105451996829576&w=2

Thanks.

-- 
~Randy
