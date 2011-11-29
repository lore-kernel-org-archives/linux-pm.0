From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] cpuidle: (powerpc) Add
 cpu_idle_wait() to allow switching of idle routines
Date: Tue, 29 Nov 2011 12:45:59 +0530
Message-ID: <4ED486AF.5020707__34449.7416205288$1322551581$gmane$org@linux.vnet.ibm.com>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>	<20111117112830.9191.1951.stgit@localhost6.localdomain6>	<1322434096.23348.6.camel@pasglop>	<4ED36A37.3030409@linux.vnet.ibm.com>	<1322512522.23348.43.camel@pasglop>	<4ED47EC2.2090802@linux.vnet.ibm.com>
	<1322550115.23348.72.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1322550115.23348.72.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/29/2011 12:31 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-11-29 at 12:12 +0530, Deepthi Dharwar wrote:
>>
>> Yes, this could be problematic as there is small window for the
>> race condition to occur . Otherwise we need to manually schedule
>> it by running a kernel thread but this would definitely have a
>> overhead and would be an overkill. 
> 
> Depends what this "window" is. IE. What are you trying to protect
> yourself against ? What's the risk ?
> 
> If it's just module unload, then stop_machine is probably your
> friend :-)
> 
> Cheers,
> Ben.
> 
> 


Yup, it is the module unload that I am worried about. Otherwise
manually doing it using kernel thread would be an overkill -:(

Regards,
Deepthi
