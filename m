From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] power: domain: no need to check return value of
 debugfs_create functions
Date: Wed, 23 Jan 2019 09:20:05 +0100
Message-ID: <CAPDyKFpZCTG-f+ejqL6v98JCfEU6zmXpVOv+cnBgM6RkHr-Etw@mail.gmail.com>
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
 <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com> <20190123075956.GA7597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123075956.GA7597@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 23 Jan 2019 at 08:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 23, 2019 at 08:44:36AM +0100, Ulf Hansson wrote:
> > On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> >
> > Doesn't this boils done to whether we want to care to check if memory
> > allocation failed?
>
> You should not care.

Okay.

>
> > Somewhere down the call chain from debugfs_create_dir(), we end up in
> > alloc_inode() and it looks like that can fail, no?
>
> Yes it can, right now it will return NULL, I'll go change that to return
> ENOMEM, but even then, your really do not care what happens as none of
> your other code flow should ever care about what debugfs does, or does
> not, do.

In that case, why don't we convert the debugfs_create_dir() and
friends, to becomes "void" functions? Or maybe that's your plan going
forward?

Kind regards
Uffe
