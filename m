From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2] PM / EM: Expose the Energy Model in debugfs
Date: Wed, 23 Jan 2019 09:28:36 +0000
Message-ID: <20190123092834.hj5v6lup4422wrmf@queper01-lin>
References: <20190122164247.19439-1-quentin.perret@arm.com>
 <20190122184136.GD31777@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122184136.GD31777@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 Jan 2019 at 19:41:36 (+0100), Greg KH wrote:
> On Tue, Jan 22, 2019 at 04:42:47PM +0000, Quentin Perret wrote:
> > The recently introduced Energy Model (EM) framework manages power cost
> > tables of CPUs. These tables are currently only visible from kernel
> > space. However, in order to debug the behaviour of subsystems that use
> > the EM (EAS for example), it is often required to know what the power
> > costs are from userspace.
> > 
> > For this reason, introduce under /sys/kernel/debug/energy_model a set of
> > directories representing the performance domains of the system. Each
> > performance domain contains a set of sub-directories representing the
> > different capacity states (cs) and their attributes, as well as a file
> > exposing the related CPUs.
> > 
> > The resulting hierarchy is as follows on Arm juno r0 for example:
> > 
> >     /sys/kernel/debug/energy_model
> >     ├── pd0
> >     │   ├── cpus
> >     │   ├── cs:450000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:575000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:700000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   ├── cs:775000
> >     │   │   ├── cost
> >     │   │   ├── frequency
> >     │   │   └── power
> >     │   └── cs:850000
> >     │       ├── cost
> >     │       ├── frequency
> >     │       └── power
> >     └── pd1
> >         ├── cpus
> >         ├── cs:1100000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:450000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:625000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         ├── cs:800000
> >         │   ├── cost
> >         │   ├── frequency
> >         │   └── power
> >         └── cs:950000
> >             ├── cost
> >             ├── frequency
> >             └── power
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > 
> > ---
> > 
> > V2: removed check on return value of debugfs_create_* (Greg KH)
> > ---
> >  kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks !
Quentin
