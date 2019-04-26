From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 25/79] docs: convert docs to ReST and rename to *.rst
Date: Fri, 26 Apr 2019 06:46:09 -0300
Message-ID: <20190426064609.7f00e013@coco.lan>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <7adf9035ae06ecc6c7e46b51cb677f0a8f61d19a.1555938376.git.mchehab+samsung@kernel.org>
        <20190425180758.GC23183@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425180758.GC23183@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Sebastian Reichel <sre@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

Em Thu, 25 Apr 2019 19:07:58 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Mon, Apr 22, 2019 at 10:27:14AM -0300, Mauro Carvalho Chehab wrote:
> > Convert the PM documents to ReST, in order to allow them to
> > build with Sphinx.  
> 
> This is massively CCed covering a large range of subsystems and is patch
> 25 of a 79 patch series so I've no context for what's going on here or
> why...  

There are two goals of this series:

1) to prepare for placing the new *.rst files under Documentation/ into an
   index file, being part of one of the books. Most of the stuff covered
   on this series either fit at the system admin guide or at the
   Kernel API documentation book;

2) to ensure that, if some edition on a file would cause warnings at
   Sphinx build, someone will notice and submit a followup patch.

You can see more details at patch 00/79:
	https://lore.kernel.org/lkml/20190422115110.26443b44@coco.lan/

In order to do that, this series has one patch per Documentation/*
sub-directory. This specific one is for the documents under
Documentation/power/ [1].

[1] btw, the title of this specific patch should be, instead:
	docs: power: convert docs to ReST and rename to *.rst

The series is long because I'm trying to cover a significant part
of the documentation files. In any case, except if an eventual
conflict might rise on some file, this patch is independent from
all other files, and should be safe to apply directly via the
subsystem git tree.

I'm working on a follow-up patch series that should be adding the
power/index.rst file into another index file - probably at
Documentation/index.rst[1]. As such patch will be adding a lot of other
index files, the best would be to merge it via the docs tree, in
order to avoid conflicts.


[1] such patch will be removing the ":orphan:" meta-tag from it
(that basically tells the build system to not produce warnings if
the file is not directly or indirectly referenced by the main
index file).

Thanks,
Mauro
