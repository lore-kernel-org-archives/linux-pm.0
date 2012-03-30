From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: Regarding CPU idle C states
Date: Fri, 30 Mar 2012 09:41:32 +0300
Message-ID: <CAGF5oy-igUy1GjB86hqnFF_ch5CqnDGO5rSJ_tQk1A6iammmpQ@mail.gmail.com>
References: <CAOUN_DfbAAsAmySTOQ_-zQLbFnCEOnvSsjdXevs9OBXkAgGCUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAOUN_DfbAAsAmySTOQ_-zQLbFnCEOnvSsjdXevs9OBXkAgGCUQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhichao Li <lzcmichael@gmail.com>, ShuoX Liu <shuox.liu@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello Zhichao,

On Thu, Mar 29, 2012 at 11:58 PM, Zhichao Li <lzcmichael@gmail.com> wrote:
> Hi,
>
> I am a third year PhD student working on power management in storage
> systems, under the Linux platform.

Good :-)

>
> We are exploring CPU DVFS, and also idle CPU C states. We figured out
> that the scheduling of CPU frequencies is exported to user level with
> the "userspace" governor. However, it seems the multiple idle C states
> are only scheduled in the kernel space (governors like "menu" and
> "ladder").

OK. Which kind of exploration you are performing? Any published paper
you would like to point?

>
> We wonder whether there is any existing kernel module or existing
> kernel patch that can export the various idle CPU C states to the user
> level for user's control as well. =A0If you could guide us to such
> code/patch, or if you have plan to do so, we'd be more than happy to
> help you testing the code for various idle CPU C states in the user
> level.


Have you seen this patch?
https://lkml.org/lkml/2012/3/5/30

It's original purpose is for debugging. One can enable of disable the
C states available. There has been some discussion about that patch
regarding its usage for userspace based governors. But it should be
enough for your purpose. In theory you could keep enabled only the C
state you want to force to be reached.


>
> Thanks for your time. Appreciated it!
>
> Regards,
>
> --
> Zhichao Li
> File Systems and Storage Lab
> Computer Science Department
> Stony Brook University
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm



-- =


Eduardo Valentin
