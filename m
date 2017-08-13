From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3] ACPI / Sleep: Check low power idle constraints for
 debug only
Date: Sat, 12 Aug 2017 17:00:22 -0700
Message-ID: <1502582422.20268.53.camel@linux.intel.com>
References: <1502475835-54818-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <18796717.B6iU8dePCh@aspire.rjw.lan>
         <1502553556.20268.47.camel@linux.intel.com>
         <CAJZ5v0iDkeCYigzY-jDyUonyDRhVuJtSmKa8qjSk0vdiPvV-EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iDkeCYigzY-jDyUonyDRhVuJtSmKa8qjSk0vdiPvV-EA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2017-08-13 at 00:37 +0200, Rafael J. Wysocki wrote:
> On Sat, Aug 12, 2017 at 5:59 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Sat, 2017-08-12 at 16:27 +0200, Rafael J. Wysocki wrote:
> > [...]
> > 
> > > 
> > > > 
> > > > +
> > > > +struct lpi_constraints {
> > > > +   char *name;
> > > > +   int min_dstate;
> > > If you store the handle here as well, you won't need to
> > > look it up every time _check_constraints() is called.
> > The reason I didn't keep handle here, I thought handle can be stale
> > or
> > change for PnP device on plug in and out. Is this not true?
> The handles don't go away on hot remove as a rule.  That may only
> happen if tables get unloaded, but basically the constraints should
> not point to anything in a table that may go away.
So we don't need to worry about this case where tables gets unloaded
and replaced? This is in a debug path, so additional overhead of path
to handle conversion may not be significant.

Thanks,
Srinivas
