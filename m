From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] Documentation: cpu-freq: Frequencies aren't always sorted
Date: Mon, 29 Oct 2018 12:47:40 +0530
Message-ID: <844626b372018192fd0e9fe399343e09ef4dc842.1540797432.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Pavel <pavel2000@ngs.ru>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The order in which the frequencies are displayed in cpufreq stats
depends on the order in which the frequencies were sorted in the
frequency table provided to cpufreq core by the cpufreq driver. They can
be completely unsorted as well.

The documentation's claim that the stats will be sorted in descending
order is hence incorrect and here is an attempt to fix it.

Reported-by: Pavel <pavel2000@ngs.ru>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpufreq-stats.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index a873855c811d..14378cecb172 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -86,9 +86,11 @@ transitions.
 This will give a fine grained information about all the CPU frequency
 transitions. The cat output here is a two dimensional matrix, where an entry
 <i,j> (row i, column j) represents the count of number of transitions from 
-Freq_i to Freq_j. Freq_i is in descending order with increasing rows and 
-Freq_j is in descending order with increasing columns. The output here also 
-contains the actual freq values for each row and column for better readability.
+Freq_i to Freq_j. Freq_i rows and Freq_j columns follow the sorting order in
+which the driver has provided the frequency table initially to the cpufreq core
+and so can be sorted (ascending or descending) or unsorted.  The output here
+also contains the actual freq values for each row and column for better
+readability.
 
 If the transition table is bigger than PAGE_SIZE, reading this will
 return an -EFBIG error.
-- 
2.19.1.568.g152ad8e3369a
