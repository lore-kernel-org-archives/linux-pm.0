From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/3] Documentation: Explain EAS and EM
Date: Wed, 6 Feb 2019 17:32:28 -0700
Message-ID: <20190206173228.30e99cf4@lwn.net>
References: <20190121111724.18234-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121111724.18234-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, juri.lelli@redhat.com, mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jan 2019 11:17:21 +0000
Quentin Perret <quentin.perret@arm.com> wrote:

> The recently introduced Energy Aware Scheduling (EAS) feature relies on
> a large set of concepts, assumptions, and design choices that are
> probably not obvious for an outsider. Moreover, enabling EAS on a
> particular platform isn't straightforward because of all its
> dependencies. This series tries to address this by introducing proper
> documentation files for the scheduler's part of EAS and for the newly
> introduced Energy Model (EM) framework. These are meant to explain not
> only the design choices of EAS but also to list its dependencies in a
> human-readable location.

So these have been sitting in my folder waiting for acks or some other
sort of discussion, but it's been awfully quiet.  Should I take them, or
do they need further work or ... ?

Thanks,

jon
