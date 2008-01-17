From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Thu, 17 Jan 2008 14:51:18 -0500
Message-ID: <200801171451.18613.lenb__29737.9196541899$1200602792$gmane$org@kernel.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
	<20080117092030.a9dfe528.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080117092030.a9dfe528.randy.dunlap@oracle.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, sujith.thomas@intel.com, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> > +static int
> > +memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
> > +			     unsigned long *max_state)
> 
> Don't put 'static int' (return type etc.) on a line by itself.
> That format is not wanted in Linux.   (many places here)

if checkpatch.pl and Lindent are happey (which they are not, totally)
then I'm satisifed witht he Linux style of the code.

Randy, if you feel strongly about this this style nit,
then change Lindent to implement it -- nagging
developers about trivia is a waste of everybody's time.

thanks,
-Len
