From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 10:12:48 -0400
Message-ID: <d120d5000707040712g76c4835bif2e226fe4710351f__3140.77965817905$1183558421$gmane$org@mail.gmail.com>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041242.59552.rjw@sisk.pl>
	<18059.32111.58643.97174@cargo.ozlabs.ibm.com>
	<200707041325.55779.rjw@sisk.pl>
	<18059.34264.421573.246262@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.34264.421573.246262@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 7/4/07, Paul Mackerras <paulus@samba.org> wrote:
> Rafael J. Wysocki writes:
>
> > They are mostly related to kernel threads, that we've already agreed no to
> > freeze (except for the ones that want that, but they will be responsible for
> > getting everything right).  The initial patches for that are in -mm and more
> > will come.
>
> Serious question: which kernel threads would actually want to be
> frozen?
>
> Threads that do no I/O at all don't care about suspend/resume and
> don't need to be frozen in any case.  Threads that issue I/O requests
> in order to service incoming I/O requests can't be frozen because of
> the possibility of deadlock.  Which leaves threads that do I/O just
> for the fun of it. :)
>
> What am I missing?
>

I like kseriod and kgameportd to be frozen. If fast resume of serio
port fails we kick the task of full resume to kseriod. But when we
hibernate and all the devices are resumed again so snapshot can be
written I don't care if touchpad failed to resume - it can be dealt
with later, when system is actually resumes. So I like that by
freezing I do not delay hibernation and all requests get simply
discarded as they are not in the image. This mostly affects
hibernation though.

Having these threads frozen also guarantees that serio/gameport device
tree is stable during susped/resume and I can process outstanding
requests later, when system is fully up.

-- 
Dmitry
