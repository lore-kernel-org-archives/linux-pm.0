From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:43:44 +1000
Message-ID: <18060.16064.519060.755991__44921.7921392576$1183596457$gmane$org@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<E1I6ATN-0007QS-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6ATN-0007QS-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Miklos Szeredi writes:

> OK, let me summarize the situation as I see it now: there are two
> camps, the pro-freezers and the anti-freezers.
> 
> Pro-freezers say:
> 
>   - don't remove the freezer, otherwise we'll have to deal with
>     numerous problems in drivers
> 
> Anti-freezers say:
> 
>   - let's remove the freezer, which causes numerous problems
> 
> Alan summerized the pro-freezer arguments well I think.  What are the
> anti-freezer arguments then?

1. The freezer cannot be guaranteed deadlock-free without constructing
   a dependency graph between tasks (both user and kernel), which is
   virtually impossible since the dependencies are not externally
   observable.

2. As a consequence of (1), we try to make a crude approximation of
   the graph by saying "only kernel threads that want to be frozen
   will be frozen" or some other similar statement.

3. However, (2) means that we can no longer guarantee that drivers
   will not get any I/O requests after their suspend method has been
   called, and therefore the freezer fails in its main objective.

4. We have an existence proof that reliable suspend can be achieved
   without the freezer.

To summarize, the argument is that the freezer is deadlock-prone and
ineffective.

Paul.
