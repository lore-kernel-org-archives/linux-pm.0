From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Wed, 02 Apr 2008 17:19:56 -0700
Message-ID: <1207181996.15616.25.camel__24699.1997737952$1207234824$gmane$org@localhost.localdomain>
References: <20080403001529.052250759@us.ibm.com>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080403001529.052250759@us.ibm.com>>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Cedric Le Goater <clg@fr.ibm.com>
List-Id: linux-pm@vger.kernel.org


On Wed, 2008-04-02 at 17:15 -0700, Matt Helsley wrote:

<snip>
> * Series
> 
>   Applies to 2.6.25-rc8-mm1
> 
>   The first patches make the freezer available to all architectures
>   before implementing the freezer subsystem.
> 
> [PATCH 1/4] Add TIF_FREEZE flag to all architectures
> [PATCH 2/4] Make refrigerator always available
> [PATCH 3/4] Implement freezer cgroup subsystem
> [PATCH 4/4] Skip frozen cgroups during power management resume

Argh. I forgot to add [RFC] tags to all of these!

>   Each patch compiles, boots, and survives basic LTP containers and controllers 
>   	tests.
>   
> Comments are welcome.
> 
> Cheers,
> 	-Matt Helsley
> 
