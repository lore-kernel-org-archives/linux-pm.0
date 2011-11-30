From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle
 power_save=off
Date: Wed, 30 Nov 2011 15:52:41 +1100
Message-ID: <1322628761.21641.40.camel@pasglop>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
	<20111117112906.9191.54050.stgit@localhost6.localdomain6>
	<1322435233.23348.19.camel@pasglop>	<4ED36A7D.9070308@linux.vnet.ibm.com>
	<1322512771.23348.45.camel@pasglop>
	<4ED47F48.2070107@linux.vnet.ibm.com>
	<4ED58614.9090204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED58614.9090204@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-11-30 at 06:55 +0530, Deepthi Dharwar wrote:
> I was trying to add a return value for power_save for all arch/powepc
> idle functions but a few of them directly call *.S  routines, as they
> are asm.
> 
> What would be a good way to change the return value  for asm
> routines ?
> Do we make a change in asm only, put the return value in r3 or write a
> wrapper function which would call these asm routines and return an
> int ?

No, add li r3,0 at the end, but beware that their return point might not
be ovbvious since we often return from an interrupt which modifies the
return address ... Let me know if there's some you can't figure out and
I'll help you.

Cheers,
Ben.
