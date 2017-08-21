From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] PM: docs: Describe high-level PM strategies and sleep states
Date: Mon, 21 Aug 2017 13:59:36 +0200
Message-ID: <CAJZ5v0g_z3p=wSrwjbKAZJJy-dnYUsp6NHC43JeAtU5FqHQ0YQ@mail.gmail.com>
References: <3053012.25nKXRPPaK@aspire.rjw.lan> <2269280.4Jsh6Gf7ai@aspire.rjw.lan>
 <7AD24A87-C1E0-44B5-9650-CD53F2AE13FB@darmarit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <7AD24A87-C1E0-44B5-9650-CD53F2AE13FB@darmarit.de>
Sender: linux-doc-owner@vger.kernel.org
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 21, 2017 at 11:51 AM, Markus Heiser
<markus.heiser@darmarit.de> wrote:
> Hi Rafael,
>
> great work, helps me and the world saving fossil fuels ;)

Thanks!

>> Am 20.08.2017 um 18:05 schrieb Rafael J. Wysocki <rjw@rjwysocki.net>:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reorganize the power management part of admin-guide by adding a
>> description of major power management strategies supported by the
>> kernel (system-wide and working-state power management) to it and
>> dividing the rest of the material into the system-wide PM and
>> working-state PM chapters.
>>
>> On top of that, add a description of system sleep states to the
>> system-wide PM chapter.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>> Documentation/admin-guide/pm/index.rst         |    5
>> Documentation/admin-guide/pm/sleep-states.rst  |  234 +++++++++++++++++++++++++
>> Documentation/admin-guide/pm/strategies.rst    |   52 +++++
>> Documentation/admin-guide/pm/system-wide.rst   |   15 +
>> Documentation/admin-guide/pm/working-state.rst |   16 +
>> 5 files changed, 320 insertions(+), 2 deletions(-)
>>
>> Index: linux-pm/Documentation/admin-guide/pm/index.rst
>> ===================================================================
>> --- linux-pm.orig/Documentation/admin-guide/pm/index.rst
>> +++ linux-pm/Documentation/admin-guide/pm/index.rst
>> @@ -5,8 +5,9 @@ Power Management
>> .. toctree::
>>    :maxdepth: 2
>>
>> -   cpufreq
>> -   intel_pstate
>> +   strategies
>> +   system-wide
>> +   working-state
>>
>> .. only::  subproject and html
>
> BTW: lets drop this C&P 'only' block here. Subprojects are only where a
> Documentation/*/conf.py exists. The build does not have sub-sub-projects
> at Documentation/*/*/conf.py level.

OK

[cut]

>
>> Index: linux-pm/Documentation/admin-guide/pm/strategies.rst
>> ===================================================================
>> --- /dev/null
>> +++ linux-pm/Documentation/admin-guide/pm/strategies.rst
>> @@ -0,0 +1,52 @@
>> +===========================
>> +Power Management Strategies
>> +===========================
>> +
>> +::
>> +
>> + Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> +
>> +The Linux kernel supports two major high-level power management strategies.
>> +
>> +One of them is based on using global low-power states of the whole system in
>> +which user space code cannot be executed and the overall system activity is
>> +significantly reduced, referred to as :doc:`sleep states <sleep-states>`.  The
>> +kernel puts the system into one of these states when requested by user space
>> +and the system stays in it until a special signal is received from one of
>> +designated devices, triggering a transition to the ``working state`` in which
>> +user space code can run.  Because sleep states are global and the whole system
>> +is affected by the state changes, this strategy is referred to as the
>> +:doc:`system-wide power management <system-wide>`.
>
> I really appreciate your hyper-ref markup using :doc:`Foo <foo>` and `Bar`_
> it is very clear when reading the raw text files in the source tree. I think
> this has its value, but it also has its drawbacks when chapters are renamed
> or moved from one file to another. Thats, why I recommend using explicitly
> anchors / may be the maintainer Jon can give us his assessment. What I mean::
>
> .. _foo:
>
> Foo
> ===
>
> lorem see :ref:`bar`
>
> .. _bar:
>
> Bar
> ===
>
> ipsum see :ref:`foo`
>
> With explicitly anchors:
>
> - there is no need to track when a chapter is renamed
> - or moved to another file,
> - same to renaming files
> - with intersphinx [1] other projects can link to such anchors
>
> [1] http://www.sphinx-doc.org/en/stable/ext/intersphinx.html

OK, makes sense.

>> +
>> +The other strategy, referred to as the
>> +:doc:`working-state power management <working-state>`,
>
> Even if you use :ref: or :doc: both are line-break-safe ...
>
> +The other strategy, referred to as the :doc:`working-state power
> +management <working-state>`, ...
>
> .. should work.

I works.

I'll send a v2 with the above changes shortly

Thanks,
Rafael
