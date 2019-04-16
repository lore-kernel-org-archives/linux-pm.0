From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 09/57] docs: cpu-freq: convert files to ReST
Date: Tue, 16 Apr 2019 06:58:15 -0300
Message-ID: <20190416065815.57fbdf2c@coco.lan>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <b2f9cc0d15d7e3058be01015be36f698debd8b14.1555382110.git.mchehab+samsung@kernel.org>
        <CAJZ5v0he8GHZ+EFJ911vgrO53NnEWDwm=_vZD4K9SVL0MahMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0he8GHZ+EFJ911vgrO53NnEWDwm=_vZD4K9SVL0MahMTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Em Tue, 16 Apr 2019 10:21:31 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Tue, Apr 16, 2019 at 4:56 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > In order to be able to build html and pdf files, convert the
> > documentation to ReST format.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Please don't convert these files.
> 
> They need more work than just semi-automatic conversion

Except for one exception (at patch 32/57), the ReST conversion on this
patch set was manually made. I basically renamed the files to
.rst, checked the errors and fixed, trying to preserve the original
document style as much as possible, while providing a good visual
for the html output.

I suspect that trying to write a script for such kind of conversion
is not an easy task, as some documents within the Kernel tree have
their own personal style, (there was even one written in LaTeX at
the CDROM docs), and I suspect that a script would end by adding 
extra unwanted markups.

> and the material in them needs to go under driver-api.

Yeah, those documents make sense to be at the driver-api set. 

The rationale why I placed the patch with actually renames on a
separate patchset (already on my devel tree, but yet to be submitted)
is that, this way, it should be easy for maintainers to pick the 
conversion patch, apply on their trees, and, if they're not ready
yet, postpone the actual rename/move thing.

> This is quite hight in my TODO list.

OK. Feel free to use this patch as a starting point if you
want.

Regards,
Mauro
