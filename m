From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 15:47:51 -0400
Message-ID: <20080312194751.GF13549__22904.6406494037$1205351376$gmane$org@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205286326.29069.16.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1205286326.29069.16.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 12, 2008 at 09:45:26AM +0800, Huang, Ying wrote:

[..]
> > I have thought through it again and try to put together some of the
> > new kexec options we can introduce to make the whole thing work. I am 
> > considering a simple case where a user boots the kernel A and then
> > launches kernel B using "kexec --load-preseve-context". Now a user
> > might save the hibernated image or might want to come back to A.
> > 
> > - kexec -l <kernel-image>
> >         Normal kexec functionality. Boot a new kernel, without preserving
> >         existing kernel's context.
> > 
> > - kexec --load-preserve-context <kernel-image>
> >         Boot a new kernel while preserving existing kernel's context.
> > 
> >         Will be used for booting kernel B for the first time.
> > 
> > - kexec --load-resume-image <resumable-core>
> 
> In original kexec-tools, this can be done through:
> kexec -l --args-none <resumable-core>
> 
> Do you need to define an alias for it?

Ok, we can get rid of --load-resume-image and go by the Eric's idea
of detecting image type and taking action accordingly.

Thanks
Vivek
