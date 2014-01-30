From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v5 1/2] mm: add kstrimdup function
Date: Thu, 30 Jan 2014 14:25:47 -0800
Message-ID: <20140130222547.19524.88444@capellas-linux>
References: <1391116318-17253-1-git-send-email-sebastian.capella@linaro.org>
 <1391116318-17253-2-git-send-email-sebastian.capella@linaro.org>
 <20140130132251.4f662aeddc09d8410dee4490@linux-foundation.org>
 <20140130214545.18296.69349@capellas-linux>
 <20140130135111.cffc7d8852dd38545bddeb75@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140130135111.cffc7d8852dd38545bddeb75@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Joe Perches <joe@perches.com>, Mikulas Patocka <mpatocka@redhat.com>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

I tested it and saw it working for those cases.

In my comments earlier, I thought Joe was underrunning the buffer, but =

that wasn't the case.

I like Joe's version better as there's no trick there and it is clearer.

Sebastian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
